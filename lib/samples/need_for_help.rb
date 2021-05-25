# frozen_string_literal: true

module Samples
  class NeedForHelp
    def self.load
      institutions = [
        {
          name: 'អង្គការ​មនុស្ស​ចាស់​កម្ពុជា',
          kind: 'ngo',
          address: 'Battambang',
          logo_url: '1.jpeg',
          country_institutions_attributes: [
            { country_name: 'Cambodia', country_code: 'kh' }
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
            { country_name: 'Cambodia', country_code: 'kh' },
            { country_name: 'Thailand', country_code: 'th' },
            { country_name: 'Vietnam', country_code: 'vn' },
            { country_name: 'Laos', country_code: 'la' },
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
            { country_name: 'Andorra', country_code: 'ad' },
            { country_name: 'Bangladesh', country_code: 'bd' },
            { country_name: 'Japan', country_code: 'jp' },
            { country_name: 'Norway', country_code: 'no' },
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
            { country_name: 'Qatar', country_code: 'qa' },
            { country_name: 'Slovakia', country_code: 'sk' },
          ],
          contacts_attributes: [
            { type: 'Whatsapp', value: '077 552 221' }
          ]
        }
      ]

      institutions.each do |hash|
        logo_url = hash.delete(:logo_url)
        logo_url = Rails.root.join("lib/samples/images/#{logo_url}")
        institution = Institution.create!(hash)
  
        if File.exists?(logo_url)
          File.open(logo_url) do |logo|
            institution.logo = logo
          end

          institution.save!
        end
      end
    end
  end
end
