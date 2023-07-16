namespace :import do
    desc "Import data from Excel file"
    task excel_data: :environment do
      require 'roo'
  
      def import_data_from_excel(file_path)
        excel = Roo::Spreadsheet.open(file_path)
  
        
        excel.each_with_index do |row, index|
          next if index == 0  
  
          brand_name = row[3]
          model_name = row[4]
  
          brand = Brand.find_or_create_by(name: brand_name)
          model = brand.models.create(name: model_name)
          
        end
      end
  
      file_path = '/Users/salimtambay/Desktop/cars.xlsx' 
      import_data_from_excel(file_path)
    end
  end
  