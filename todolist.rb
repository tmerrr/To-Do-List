class ToDoList
	def initialize
		@arr = Array.new
		@sorted_array = @arr
		@sort = 'recent'
		@add_sort = false
		puts "We've started a new To-Do List."
		add_item
	end

	def add_item
		puts "NOTE: Type nothing and hit enter to exit the program."
		puts "What would you like to add? Type 'sort' or 'remove' for these actions"
		item = gets.strip.chomp
		puts
		case item
		when 'sort'
			sort_items
		when 'remove'
			remove_item
		when ''
			abort "Manual exit confirmed."
		else
			@arr.push item
			@sorted_array = @arr
			case @sort
			when 'recent'
				sort_recent
			when 'old'
				sort_oldest
			else
				@add_sort = true
				sort_alpha
			end
		end
	end

	def remove_item
		puts "What item would you like to remove?"
		puts "NOTE: Just hit Enter on it's own to cancel"
		item = gets.strip.chomp
		puts
		case item
		when ''
			add_item
		else
			if @arr.include?(item)
				item_index = @arr.index(item)
				@arr.delete_at(item_index)
				@sorted_array = @arr
			else
				puts "'#{item}' not found"
				remove_item
			end

			if @arr.empty?
				puts "Your To-Do list is now empty"
				add_item
			else
				case @sort
				when 'recent'
					sort_recent
				when 'old'
					sort_oldest
				else
					@add_sort = true
					sort_alpha
				end
			end
		end
	end

	def sort_alpha
		
		# => created my own sort method, because I wanted capital letters to be counted the same as lowercase.
		# => Except when the same word occurred, the capital would come first.

		temp_arr = @arr.clone
		sorted = []
		first_index = 0

		while temp_arr.length > 0
			first = temp_arr[first_index]
			last = temp_arr.last
			last_index = temp_arr.length - 1
			if first_index == last_index
				sorted.push temp_arr.pop
				first_index = 0
			elsif (first.downcase < last.downcase) || ((first.downcase == last.downcase) && (first < last))
				temp_arr.push first
				temp_arr.delete_at(first_index)
				first_index = 0
			else
				first_index += 1
			end
		end
		@sorted_array = sorted
		if @add_sort == true	# => If an item as just been added or removed, then we only reverse the sorted array if sort is set to 'rev alpha'
			if @sort == 'rev alpha'
				@sorted_array.reverse!
			end
		else					# => If an item HASN'T just been added, then we reverse the sort if it had already been sorted by alpha.
			if @sort == 'alpha'
				@sorted_array.reverse!
				@sort = 'rev alpha'
			else
				@sort = 'alpha'
			end
		end
		@add_sort = false
		list_items
	end

	def sort_recent
		@sort = 'recent'
		@sorted_array = @arr.reverse
		list_items
	end

	def sort_oldest
		@sort = 'old'
		@sorted_array = @arr
		list_items
	end

	def sort_items
		puts "How would you like to sort your list?"
		puts "Options: recent, oldest, alpha.  Enter a blank to cancel."
		choice = gets.strip.chomp.downcase
		puts
		case choice
		when 'recent'
			sort_recent
		when 'oldest'
			sort_oldest
		when 'alpha'
			sort_alpha
		when ''
			list_items
		else
			puts "#{choice} not recognised as a command."
			sort_items
		end
	end

	def list_items
		puts "Your To-Do List:"
		num = 1
		@sorted_array.each do |items|
			puts "#{num}.  #{items}"
			num = num + 1
		end
		puts
		add_item
	end

end

ToDoList.new