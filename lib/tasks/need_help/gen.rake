namespace :need_help do
  task gen: :environment do
    institutions = [
      {
        name: 'អង្គការ​មនុស្ស​ចាស់​កម្ពុជា',
        kind: 'ngo',
        address: 'Battambang',
        logo_url: '1.jpeg',
        country_institutions_attributes: [
          { country_name: 'Cambodia' }
        ],
        contacts_attributes: [
          { type: 'Phone', value: '012 801 820' }
        ]
      },
      {
        name: 'អភិវឌ្ឍន៍សហគមន៍ជនបទនិងបរិស្ថាន ( អាសេដូ )',
        kind: 'gov',
        address: 'Phnom Penh',
        logo_url: '2.jpeg',
        country_institutions_attributes: [
          { country_name: 'Cambodia' },
          { country_name: 'Thailand' },
          { country_name: 'Vietnam' },
          { country_name: 'Laos' },
        ],
        contacts_attributes: [
          { type: 'Phone', value: '054 710 446' },
          { type: 'Facebook', value: 'fb.com/test1' },
          { type: 'Whatsapp', value: '054 710 446' },
        ]
      },
      {
        name: 'ផ្ទះទឹកដូងកម្ពុជា',
        kind: 'other',
        address: 'Battambang',
        logo_url: '4.jpg',
        country_institutions_attributes: [
          { country_name: 'Andorra' },
          { country_name: 'Bangladesh' },
          { country_name: 'Japan' },
          { country_name: 'Norway' },
        ],
        contacts_attributes: [
          { type: 'Phone', value: '077 552 221' },
          { type: 'Facebook', value: 'fb.com/test2' },
        ]
      },
      {
        name: 'អង្គការមរតក',
        kind: 'ngo',
        address: 'Koh Kong',
        logo_url: '3.jpeg',
        country_institutions_attributes: [
          { country_name: 'Qatar' },
          { country_name: 'Slovakia' },
        ],
        contacts_attributes: [
          { type: 'Whatsapp', value: '077 552 221' }
        ]
      }
    ]
    
    institutions.each do |hash|
      logo_url = hash.delete(:logo_url)
      logo_url = Rails.root.join("lib/tasks/need_help/images/#{logo_url}")
      institution = Institution.create!(hash)

      if File.exists?(logo_url)
        institution.logo.attach(
          io: File.open(logo_url),
          filename: File.basename(logo_url)
        )
        institution.save!
      end
    end
  end
end
