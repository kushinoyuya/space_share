module ApplicationHelper

# dateを見やすくする
def simple_date(date)
    return  date.strftime('%Y年%-m月%-d日')
end


end
