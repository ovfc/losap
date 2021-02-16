module MembersHelper
  def format_date(date)
    date.strftime("%a, %d %b")
  end

  def locked?(month)
    LockedMonth.find_by_month(month)
  end

  def show_month(month)
    month.strftime("%B %Y")
  end
  
  def previous_month(member, month)
    link_to('Previous Month', member_month_url(member, 
                                               :year => month.prev_month.year, 
                                               :month => month.prev_month.month))
  end

  def next_month(member, month)
    unless month.next_month > Date.today
      ' | ' + link_to('Next Month', member_month_url(member,
                                                     :year => month.next_month.year,
                                                     :month => month.next_month.month))
    end
  end

  def render_sleep_ins_and_standbys_and_collateraldutys(member, month)
    sleep_ins_and_standbys_and_collateraldutys = member.sleep_ins_and_standbys_and_collateraldutys(:month => month)
    if sleep_ins_and_standbys_and_collateraldutys.empty?
      content_tag 'tr', content_tag('td', 'No sleep-ins or standbys or collaterdutys this month', :colspan => "4")
    else
      sleep_ins_and_standbys_and_collateraldutys_helper(sleep_ins_and_standbys_and_collateraldutys)
    end
  end

  private
  def sleep_ins_and_standbys_and_collateraldutys_helper(list)
    ret = ""

    until list.empty? do
      o = list.shift
      ret += "<tr>\n"
      ret += "  <td>#{h format_date(o.date)}</td>\n"

      if o.is_a? Standby
        ret += "  <td>" + render(:partial => o)
        
        while (list.first and list.first.is_a?(Standby) and
               list.first.date == o.date) do
          ret += "<br/>\n" + render(:partial => list.shift)
        end
        
        ret += "</td>\n"
        
        if list.first && list.first.date == o.date
          ret += "  <td>#{render :partial => list.shift}</td>\n"
          ret += "  <td>#{render :partial => list.shift}</td>\n"
        else
          ret += "  <td>&nbsp;</td>"
          ret += "  <td>&nbsp;</td>\n"
        end
      elsif o.is_a? Collateralduty
        ret += "  <td>&nbsp;</td>\n"
        ret += "  <td>" + render(:partial => o)
        
        while (list.first and list.first.is_a?(Collateralduty) and
                list.first.date == o.date) do
          ret += "<br/>\n" + render(:partial => list.shift)
        end
        
        ret += "</td>\n"
        if list.first && list.first.date == o.date
          ret += "  <td>#{render :partial => list.shift}</td>\n"
        else
          ret += "  <td>&nbsp;</td>"
        end
      else
        ret += "  <td>&nbsp;</td>\n"
        ret += "  <td>&nbsp;</td>\n"
        ret += "  <td>#{render :partial => o}</td>\n"
      end

      ret += "</tr>\n"
    end

    ret
  end
end
