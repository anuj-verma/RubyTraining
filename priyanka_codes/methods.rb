
	to = read_input(expr, 'ID').to_sym
	to = read_input(expr, 'ID').to_sym
	to = read_input(expr, 'ID').to_sym
	to = read_input(expr, 'ID').to_sym
	to = read_input(expr, 'ID').to_sym
yntaxError ((irb):16: syntax error, unexpected '=', expecting ')'
def func(arg1 = 0, arg2, arg3 = 0)
                              ^)
2.5.0 :019 > def func(arg1 = 0, arg2 = 0, arg3 = 0)
2.5.0 :020?>   p "#{arg1}#{arg2}#{arg3}"
2.5.0 :021?>   end
 => :func 
2.5.0 :022 > def func(arg1 = 0, arg2 = 0, arg3 )
2.5.0 :023?>   p "#{arg1}#{arg2}#{arg3}"
2.5.0 :024?>   end
 => :func 
2.5.0 :025 > func(1)
"001"
 => "001" 
2.5.0 :026 > def func( input )
2.5.0 :027?>   puts input
2.5.0 :028?>   end
 => :func 
2.5.0 :029 > func({'a': 'a', 'b': 'b'})
{:a=>"a", :b=>"b"}
 => nil 
2.5.0 :030 > func('a': 'a', 'b': 'b')
{:a=>"a", :b=>"b"}
 => nil 
2.5.0 :031 > def func(var, input)
2.5.0 :032?>   puts var
2.5.0 :033?>   puts input
2.5.0 :034?>   end
 => :func 
2.5.0 :035 > func('a' ,'a': 'a', 'b': 'b')
a
{:a=>"a", :b=>"b"}
 => nil 
2.5.0 :036 > def address(city, state, zipcode)
2.5.0 :037?>   puts city
2.5.0 :038?>   puts state
2.5.0 :039?>   puts zipcode
2.5.0 :040?>   end
 => :address 
2.5.0 :041 > address('pune', 'maharashtra', '41101')
pune
maharashtra
41101
 => nil 
2.5.0 :042 > def address(city:, state:, zipcode:)
2.5.0 :043?>   puts city
2.5.0 :044?>   puts state
2.5.0 :045?>   puts zipcode
2.5.0 :046?>   end
 => :address 
2.5.0 :047 > address('pune', 'maharashtra', '41101')
Traceback (most recent call last):
        3: from /home/pinku/.rvm/rubies/ruby-2.5.0/bin/irb:11:in `<main>'
        2: from (irb):47
        1: from (irb):42:in `address'
ArgumentError (wrong number of arguments (given 3, expected 0; required keywords: city, state, zipcode))
2.5.0 :048 > address(city: 'pune', state: 'maharashtra', zipcode: '41101')
pune
maharashtra
41101
 => nil 
2.5.0 :049 > address(state: 'pune', city: 'maharashtra', zipcode: '41101')
maharashtra
pune
41101
 => nil 
2.5.0 :050 > def address(city:0, state:, zipcode:)
2.5.0 :051?>   puts city
2.5.0 :052?>   puts state
2.5.0 :053?>   puts zipcode
2.5.0 :054?>   end
 => :address 
2.5.0 :055 > address(state: 'pune', city: 'maharashtra', zipcode: '41101')
maharashtra
pune
41101
 => nil 
2.5.0 :056 > address(state: 'pune', zipcode: '41101')
0
pune
41101
 => nil 
2.5.0 :057 > def address(city = 0, state:, zipcode:)
2.5.0 :058?>   puts city
2.5.0 :059?>   puts state
2.5.0 :060?>   puts zipcode
2.5.0 :061?>   end
 => :address 
2.5.0 :062 > address(state: 'pune', zipcode: '41101')
0
pune
41101
 => nil 
2.5.0 :063 > address('pune', state: 'maharashtra', zipcode: '41101')
pune
maharashtra
41101
 => nil 
2.5.0 :064 > def func(*var)
2.5.0 :065?>   end
 => :func 
2.5.0 :066 > func(1, 2, 3)
 => nil 
2.5.0 :067 > func(1)
 => nil 
2.5.0 :068 > func()
 => nil 
2.5.0 :069 > def func(*var)
2.5.0 :070?>   puts var.class
2.5.0 :071?>   puts var
2.5.0 :072?>   end
 => :func 
2.5.0 :073 > func(1, 2, 3)
Array
1
2
3
 => nil 
2.5.0 :074 > def func(*var)
2.5.0 :075?>   for x in var do
2.5.0 :076 >       
[2]+  Stopped                 irb
pinku:~/Desktop/git_training-master/priyanka_codes(priyanka_bank_application)$ def func(*var)
-bash: syntax error near unexpected token `('
pinku:~/Desktop/git_training-master/priyanka_codes(priyanka_bank_application)$ irb
2.5.0 :001 > def func(*var)
2.5.0 :002?>   result = 0
2.5.0 :003?>   var.each{ |num, result| result +=num}
2.5.0 :004?>   result
2.5.0 :005?>   end
 => :func 
2.5.0 :006 > func(1, 2)
Traceback (most recent call last):
        5: from /home/pinku/.rvm/rubies/ruby-2.5.0/bin/irb:11:in `<main>'
        4: from (irb):6
        3: from (irb):3:in `func'
        2: from (irb):3:in `each'
        1: from (irb):3:in `block in func'
NoMethodError (undefined method `+' for nil:NilClass)
2.5.0 :007 > def func(*var)
2.5.0 :008?>   result = 0
2.5.0 :009?>   var.each{ |num| result += num}
2.5.0 :010?>   result
2.5.0 :011?>   end
 => :func 
2.5.0 :012 > func(1, 2)
 => 3 
2.5.0 :013 > def func(*var)
2.5.0 :014?>   var.sum
2.5.0 :015?>   end
 => :func 
2.5.0 :016 > func(1, 2)
 => 3 
2.5.0 :017 > def func(*var)
2.5.0 :018?>   var.sort
2.5.0 :019?>   end
 => :func 
2.5.0 :020 > func(3,2,5)
 => [2, 3, 5] 
2.5.0 :021 > numbers = [1, 2, 3]
 => [1, 2, 3] 
2.5.0 :022 > numbers.sum
 => 6 
2.5.0 :023 > numbers = [1, 5, 3]
 => [1, 5, 3] 
2.5.0 :024 > numbers.sort
 => [1, 3, 5] 
2.5.0 :025 > numbers
 => [1, 5, 3] 
2.5.0 :026 > info = [ {id: 'id1', name: 'anc'}, {id: 'abcj', name: 'andk'}]
 => [{:id=>"id1", :name=>"anc"}, {:id=>"abcj", :name=>"andk"}] 
2.5.0 :027 > info.sort(){|x, y| y.length <=> x.length} 
 => [{:id=>"id1", :name=>"anc"}, {:id=>"abcj", :name=>"andk"}] 
2.5.0 :028 > info = [ {id: 5, name: 'anc'}, {id: 2, name: 'andk'}]
 => [{:id=>5, :name=>"anc"}, {:id=>2, :name=>"andk"}] 
2.5.0 :029 > info.sort(){|x, y| y[:id] <=> x[:id]} 
 => [{:id=>5, :name=>"anc"}, {:id=>2, :name=>"andk"}] 
2.5.0 :030 > info.sort(){|x, y| x[:id] <=> y[:id]} 
 => [{:id=>2, :name=>"andk"}, {:id=>5, :name=>"anc"}] 
2.5.0 :031 > info = [ {id: 'id1', name: 'anc'}, {id: 'abcj', name: 'andk'}]
 => [{:id=>"id1", :name=>"anc"}, {:id=>"abcj", :name=>"andk"}] 
2.5.0 :032 > info.sort(){|x, y| y[:id].length <=> y[:id].length} 
 => [{:id=>"id1", :name=>"anc"}, {:id=>"abcj", :name=>"andk"}] 
2.5.0 :033 > info.sort(){|x, y| y[:id].length <=> x[:id].length} 
 => [{:id=>"abcj", :name=>"andk"}, {:id=>"id1", :name=>"anc"}] 

	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	return to if (user_information[to] != nil && to != id)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
