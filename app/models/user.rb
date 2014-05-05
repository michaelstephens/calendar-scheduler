class User < ActiveRecord::Base
  include Humanity::Base

  has_many :emails
  has_many :permits
  has_many :groups, through: :permits
  belongs_to :group

  alias_attribute :netid, :username

  scope :custom_search, -> query {
    fields = %w{username first_name last_name full_name users.title users.department email users.employee_id job_positions.title job_positions.department}
    condition = fields.map{|f| "#{f} LIKE ?"}.join(' OR ')
    includes(:job_positions).where(condition, *(["%#{query}%"]*fields.length)).uniq unless query.blank?
  }

  def admin?
    self.has_role?(:admin) || self.has_role?(:developer)
  end

  def affiliations
    @affiliations ||= roles.where(Humanity::Assignment.by_source(:affilation))
  end

  def entitlements
    @entitlements ||= roles.where(Humanity::Assignment.by_source(:entitlement))
  end

  def authorized_roles
    roles.map(&:to_s) & Authorization::Engine.instance.roles.map(&:to_s)
  end

  def update_from_cas!(extra_attributes)
    cas_attr = HashWithIndifferentAccess.new(extra_attributes)

    entitlements = User.urns_to_roles(cas_attr[:eduPersonEntitlement], Settings.urn_namespaces)
    self.username ||= cas_attr[:cn].try(:first)
    self.photo_url ||= cas_attr[:url].try(:first)
    self.department ||= cas_attr[:department].try(:first)
    self.title ||= cas_attr[:title].try(:first)
    self.email ||= cas_attr[:mail].try(:first)
    self.first_name ||= cas_attr[:eduPersonNickname].try(:first)
    self.last_name ||= cas_attr[:sn].try(:first)
    self.phone_numbers ||= cas_attr[:telephonenumber].join(", ") unless cas_attr[:telephonenumber].nil?


    self.save \
    && self.update_roles!(cas_attr[:eduPersonAffiliation], :affiliation) \
    && self.update_roles!(entitlements, :entitlement)
  end

  # Find URNs that match the namespaces and remove the namespace
  # See http://en.wikipedia.org/wiki/Uniform_Resource_Name
  def self.urns_to_roles(urns, nids)
    return [] if urns.blank?

    clean_urns = urns.map { |e| e.gsub(/^urn:/i, '') }
    clean_nids = nids.map { |n| n.gsub(/^urn:/i, '') }

    clean_urns.map { |urn|
      clean_nids.map { |nid|
        urn[0...nid.length] == nid ? urn[nid.length..urn.length] : nil
      }
    }.flatten.compact
  end
end