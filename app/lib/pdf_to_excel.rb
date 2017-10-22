# coding: utf-8
# It uses pdf-reader gem to extract the content from the PDF file.


class PdfToExcel	
    
    def initialize(path, page)         
        @reader = PDF::Reader.new(path)
        @header=nil
        @page=page.to_i
        @matrix=prepare_data
    end
    
    # returns a 2D array that contains the extracted data from the pdf .
    # 2D table is prepared by spliting the raw text using regex
    # it's result is assigned into instance variable @matrix
    
    def prepare_data 
        table=Array.new
        flag=true
        flag2=false
        count=0 
        @reader.pages.each_with_index do |page,i| 
        break if i >= @page          
        #(?!([a-zA-Z\-0-9]+))
        #text  = page.text.gsub(/\n\s{1}+[0-9]{1}+,[0-9]\s{1}+/,'      ')
        rows=page.text.split(/\n/)         
        rows.each_with_index do|row,ind|
            temp=row.split(/\s{2}+/)
         
            if temp.length == 1 && temp[0].include?('-')
                flag2=true
                rows[ind+1].insert(0, temp[0]) if !rows[ind+1].nil?
                flag2=false;
            end
                if temp.length >9
                temp.delete_at(1)     
                end          
            if temp.length ==9
                table << temp unless (temp.empty?  || row.include?("Portfolio Name"))
                
            end
            if  flag && row.include?("Portfolio Name")
                non_standardized_header row
                flag=false
            end
        end	      
        end          
        return table
    end
    
    # This method receive the header row
    # parse that row, and assign it to instance variable @header
    # used to write header in the CSV

    def non_standardized_header(row)
        @header=row.split(/\s{2}+/).reject{|a|a.empty?}   
        @header[1].insert(8,'--')
        @header[1]=@header[1].split(/--/)
        @header.insert(1,'Incep Date')
        @header=@header.flatten
    end


    # return the generated CSV file path
    # It used Axlsx gem to create the CSV
    
    def to_csv   
        package = ::Axlsx::Package.new			
            workbook = package.workbook
            workbook.add_worksheet(name: "Transamerica Variable") do |sheet|
            sheet.add_row @header, :b=>true,:sz=>11
            @matrix.each_with_index do |row,o_in|             
                r=row.reject{|a| a==""}
                r[0]=r[0].gsub(/[0-9]*,{1}+[0-9]*/,'')
                r[0]=r[0].gsub(/(?<=[a-zA-z])\d{1}+/,'')
                next if validate_checks(r)
                r.each do |text|
                    #text.strip!
                    #text.insert(0,'\'') if text[0]!='\''
                end
                sheet.add_row r,:alignment => { :horizontal => :center,
                                            :vertical => :center ,
                                            :wrap_text => true}         
                end
        end
        file_name_path="public/#{get_name('output')}"
        package.serialize(file_name_path)
        return file_name_path
    end

    # returns the formated name by appending the current time stamp
    # Used for for setting the CSV file Name
    
    def get_name(name)
        name+"_#{get_time_stamp}.xlsx"
    end

    
    #return the formatted time stamp
    def get_time_stamp
        Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    end
   

    def validate_checks(r)
        return r[0].length>70 || !r[1].nil? && r[1].length>70 
        return false     
    end
end
