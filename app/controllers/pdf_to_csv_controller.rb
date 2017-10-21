class PdfToCsvController < ApplicationController

    def extract_data
      
        path = File.join("public/uploaded.pdf")
        File.open(path, "wb") { |f| f.write(params[:pdf_file].read) }          
        ob=PdfToCsv.new(path)

         csv_file=ob.to_csv
         send_file File.join(Rails.root, csv_file)
    
        
    end
end
