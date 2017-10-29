class WbTransPortfolioController < ApplicationController

	def upload_trans_portfolio_index
		if params[:trans_portfolio_index][:file].nil? 
            flash[:error]="File can't be blank"        
        else
        	uploaded_file = params[:trans_portfolio_index][:file].tempfile	
            process_file uploaded_file         
            process_trans_portfolio_index       
        end
	end 

	def upload_trans_portfolio	
		if params[:trans_portfolio][:file].nil? 
            flash[:error]="File can't be blank"        
        else
       	   uploaded_file = params[:trans_portfolio][:file].tempfile	
           process_file uploaded_file
           @data = process_trans_portfolio     
    	end
    end


    def extract_data
        if params[:pdf_file].nil? || params[:num_of_page].nil?
            flash[:error]="File and Number of pages can't be blank"        
        else
            time_s=Time.now.strftime('%Y-%m-%d_%H-%M-%S')
            path = File.join("public/uploaded_#{time_s}.pdf")
            File.open(path, "wb") { |f| f.write(params[:pdf_file].read) }          
            ob=::PdfToExcel.new(path,params[:num_of_page]) #check the code in app/lib/pdf_to_excel.rb
            csv_file=ob.to_csv
            send_file File.join(Rails.root, csv_file) 
        end   
    end


  

    def update_subaccount_index	
    	@sub_account_index = WbVaTransPortnameIndex.find_by_id params[:sub_account][:old_subaccount_id]
    	if !@sub_account_index.nil?
    		@sub_account_index.name= params[:sub_account][:new_subaccount_name]
    		@sub_account_index.comment = params[:sub_account][:comment]
    		@sub_account_index.last_date_updated = Time.zone.now		
    		@sub_account_index.save
    		@row_id=params[:sub_account][:row_id]
    	end
    end

    def create_subaccount_index
    	@sub_account_index = WbVaTransPortnameIndex.new
    	@sub_account_index.name = params[:add_sub_account][:new_subaccount_name]
    	@sub_account_index.status=true
    	@sub_account_index.last_date_updated=Time.zone.now
    	@sub_account_index.comment = params[:add_sub_account][:comment]
    	@sub_account_index.save
    	@row_id=params[:add_sub_account][:row_id]	
    end


    def process_file(uploaded_file)
        @file = open_file(uploaded_file)
    end

    private
	def process_trans_portfolio_index	
	   (0..@file.last_row).each do |i|
	      row = @file.row(i)
	      logger.info "  Uploading Transamerica portfolio Index #{row}"
		    begin
		        if !row[0].nil?
		        	port_index= WbVaTransPortnameIndex.new
		        	port_index.name=row[0].strip
		        	port_index.status=true
		        	port_index.last_date_updated=Time.zone.now
		        	port_index.save
				end
				rescue Exception => e
		        logger.info "validate record #{e.message}"	        
	     	end
		end
	end


	private
	def extract_excel_from_pdf
	end

	private
	def process_trans_portfolio
		data=[]
		(2..@file.last_row).each do |i|
			data[i-2]=[]
	      row = @file.row(i)
	      logger.info "  Uploading Transamerica portfolio #{row}"
		    begin
		        if !row[0].nil?
		        	account = WbVaTransPortnameIndex.where("name = ?",row[0].strip).first
		        	data[i-2] << (account.nil? ? false : true)
		        	data[i-2] << row
		        	data[i-2].flatten!	
				end
				rescue Exception => e
		        logger.info "validate record #{e.message}"	        
	     	end
		end
		data
	end
	private
	def open_file(file)
	  	ext=File.extname file
	    case ext
	      when ".csv" then
	        Roo::CSV.new(file.path,csv_options: {encoding: Encoding::UTF_8})
	      when ".xls" then
	        Roo::Excel.new(file.path, file_warning: :ignore)
	      when ".xlsx" then
	        Roo::Excelx.new(file.path, file_warning: :ignore)
	      else
	        raise "Unknown file type: #{file}"
	   	  end
	end
end


