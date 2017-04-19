class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    text_wo_spaces = @text.gsub(" ","")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")

    @character_count_without_spaces = text_wo_tabs.length

    @word_count = @text.split.length

    lowercase_text = @text.downcase
    lowercase_text_wo_punc=lowercase_text.gsub(/[^a-z0-9\s]/i, "")
    split_lowercase_text = lowercase_text_wo_punc.split
    lowercase_special_word = @special_word.downcase
    @occurrences = split_lowercase_text.count(lowercase_special_word)


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = ((((@apr/100)/12) * @principal) /(1 - (1 + ((@apr/100)/12)) ** ( -(@years * 12))))


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @sorted_numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum

    middle=@count/2
    if @count.even?
      median = (@sorted_numbers[middle]+ @sorted_numbers[middle-1])/2
    else
      median = @sorted_numbers[middle]
    end
    @median = median

    @sum = @numbers.sum

    @mean = @sum / @count

    @variance = @numbers.inject(0.0) {|s,x| s + (x - @mean)**2} / @count

    @standard_deviation = (@variance)**(0.5)

    temp_mode=@sorted_numbers[0]
    i=1
    while i < @count
      count_i=@sorted_numbers.count(@sorted_numbers[i])
      if count_i>@sorted_numbers.count(temp_mode)
        temp_mode=i
      end
      i+=1
      @mode=temp_mode
    end
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
