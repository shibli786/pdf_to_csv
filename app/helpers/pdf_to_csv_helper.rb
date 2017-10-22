module PdfToCsvHelper

    def get_num_list
    list= Array.new
    list << ['No of Pages','']
        for i in 1..30
            list << [i,i]
        end
        return list
    end
end
