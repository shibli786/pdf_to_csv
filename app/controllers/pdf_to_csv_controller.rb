class PdfToCsvController < ApplicationController

    def extract_data
        if params[:pdf_file].nil? || params[:num_of_page].nil?
            flash[:error]="File and Number of pages can't be blank"        
        else
            time_s=Time.now.strftime('%Y-%m-%d_%H-%M-%S')
            path = File.join("public/uploaded_#{time_s}.pdf")
            File.open(path, "wb") { |f| f.write(params[:pdf_file].read) }          
            ob=::PdfToExcel.new(path,params[:num_of_page])
            csv_file=ob.to_csv
            send_file File.join(Rails.root, csv_file) 
        end   
    end
end
