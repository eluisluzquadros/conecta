class CsvCompany
  attr_accessor :name, :size, :description,:segments,:types,:competences,
  :competence_value, :logo, :contact_name, :contact_site, :contact_email,
  :contact_phone, :address_info, :status
  @@competence_area_array = nil
  def initialize
    CsvCompany.create_competence_area_array()
  end

  def insert_to_db

    company = Company.new(name: @name, description: @description, size: @size, logo: @logo, address: @address_info, status: @status)

    @email = @contact_email || "exemplo@domain.com"

    contact_object = Contact.new(site: @contact_site, phone: @contact_phone, contact_name: @contact_name,
    email: @email)
    company.contact = contact_object

    @segments.each do |segment|
      segment_object = Segment.first(name: segment)
      if !segment_object
        segment_object = Segment.create(name: segment)
      end
      company.segments.push(segment_object)
    end
    @types.each do |type|
      type_object = CompanyType.first(name: type)
      if !type_object
        type_object = CompanyType.create(name: type)
      end
      company.company_types.push(type_object)
    end
    @competences.each do |competence|

      competence_object = Competence.first(name: competence[:name])
      if !competence_object
        competence_area = @@competence_area_array[competence[:area_number].to_i]
        competence_object = Competence.create(name: competence[:name], competence_area: competence_area)
      end
      competence_institution_object = CompetenceInstitution.new(competence_value: competence[:competence_value].to_i )
      competence_institution_object.institution = company
      competence_institution_object.competence = competence_object
      competence_institution_object.save
    end
    company.save
  end
  def self.create_competence_area_array
    if !@@competence_area_array
      @@competence_area_array = [
        "",
        CompetenceArea.create(name: "Hardware"),
        CompetenceArea.create(name: "Software"),
        CompetenceArea.create(name: "Administração"),
        CompetenceArea.create(name: "Serviços"),
        CompetenceArea.create(name: "Soluções Ecológicas"),
        CompetenceArea.create(name: "Comercial")
      ]
    end
  end
end
