class PdfToCsv	
    # require 'pdf-reader'
    # require 'byebug'
    # require 'axlsx'
    # require 'date'
    
        def initialize(path)
            
            @reader = PDF::Reader.new(path)
            @header=nil
            @matrix=prepare_data
            
        end
    
    
    
        def prepare_data
            table=Array.new
            flag=true
            flag2=false
            count=0 
            @reader.pages.each_with_index do |page,i| 
               break if i > 3          
            rows=page.text.split(/\n{3}+/)               
            rows.each do|row|
                temp=row.split(/\s{2}/)
                table << temp unless (temp.empty?  || row.include?("Portfolio Name"))
                if flag && row.include?("Portfolio Name")
                    non_standardized_header row
                    flag=false
                end
            end	 
           
         end

            puts "counts  #{count}"
            return table
        end
    
        def non_standardized_header(row)
            @header=row.split(/\n/).reject{|a|a.empty?}[3]
            @header=@header.split(/\s{2}/).reject{|head_title|head_title.empty?}
            #@header[1].insert(0, 'Incep ')
            @header[1].insert(8,'--')
            @header[1]=@header[1].split(/--/)
            @header.insert(1,'Incep Date')
            @header=@header.flatten
    
        end
    
        def standardized_header
            
        end
    
    
    
    
        def to_csv      
                 	
           package = ::Axlsx::Package.new			
              workbook = package.workbook
             workbook.add_worksheet(name: "Transamerica Variable") do |sheet|
                sheet.add_row @header, :b=>true,:sz=>11
                @matrix.each_with_index do |row,o_in|
                  
                    r=row.reject{|a| a==""}
                    
                    
                    next if validate_checks(r) || o_in<7
                   r.each do |text|
                        text.strip!				
                        text.gsub!(/\n/,'')
                    end
                    if r.length <= 9
                        sheet.add_row r  
                    else
                        r[0]+=" #{r[1]}"
                        r.delete_at(1)
                        sheet.add_row r              
                    end
                    if row.join(" ").include?('Non-Standardized')
                        sheet.add_row [" "]
                        sheet.add_row @header,:sz=>11,:b=>true
                    end                 
                 end
            end
            file_name_path="public/new_csv.xlsx"
            package.serialize(file_name_path)
          return file_name_path
        end
    
        def validate_checks(r)
            return r[0].length>70 || !r[1].nil? && r[1].length>70
            return false
                
        end
    
    end
    
    # class Date
    #   def self.parsable?(string)
    #     begin
    #       Date.strptime(string.strip, '%m/%d/%Y')
    #       true
    #         rescue ArgumentError
    #       false
    #     end
    #   end
    # end
    
    
 
    
    
    
    
        