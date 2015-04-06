module Infuser
  class Contact < Infuser::Models::Base

    define_schema :first_name, :middle_name, :nickname, :last_name, :suffix, :title,
      :company_id, :job_title, :assistant_name, :assistant_phone,
      :contact_notes, :contact_type,
      :referral_code, :spouse_name, :username, :website,
      :date_created, :last_updated, :created_by

    belongs_to :company

    has_collection :emails
    has_collection :phones
    has_collection :faxes
    has_collection :addresses

    INFUSIONSOFT_MAPPING = {
      'CompanyId' => 'CompanyID',
      'OwnerId' => 'OwnerID'
    }

    private

    def add
      dedup_type = Infuser::Configuration.duplication_check
      if dedup_type
        dedup_type = dedup_type.to_s.split('_').map(&:titlecase).join
        unless ['Email', 'EmailAndName', 'EmailAndNameAndCompany'].include?(dedup_type)
          raise(Infuser::ArgumentError, 'Invalid duplication_check specified in Configuration.')
        end
      end

      @id = if dedup_type
        client.get('ContactService.addWithDupCheck', data, dedup_type)
      else
        client.get('ContactService.add', data)
      end
    end

  end
end