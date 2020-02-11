#set your working drive to the location that you wish your R files to be located.

setwd ("D:\\R_folder")

#This script checks for any missing packages and then installs them. Afterwards
#all packages are loaded. I like this set up, its a bit of an all-in-one. 

load.lib <- c("RedditExtractoR", "plyr", "ggplot2")

install.lib<-load.lib[!load.lib %in% installed.packages()]
for(lib in install.lib) install.packages(lib,dependencies=TRUE)
sapply(load.lib,require,character=TRUE)

#The code for scraping reddit is pretty straight forward. The command
#reddit_urls( ) is used to search. search_terms is the search option.
#Due to the API, its recommended to search a single term at a time rather 
#than multiple terms. The subreddit = command is used to restrict your 
#search to a single subreddit rather than all of reddit. 
#sort_by = has three options. Here we are sorting by "new" but "comments"
#can also be used. Sorting by "comments" will sort by the number of comments 
#in a thread. Finally, page_threshold states how many search
#page results to display. Each unit is equal to 50 possible search results.
#With 10, the max return is 500. 
#A minimum number of comments per thread can also be set as an option 
#using cn_threshold =. The value you set this to will determine the comment
#threshold. For example, adding the option cn_threshold = 5 would mean that 
#only threads with at least 5 comments would be displayed. The default is 0.
#Finally, do not forget your commas between options. You will get an error 
#that will likely say "Error: unexpected symbol in:". 


links <- reddit_urls(
	search_terms   = "education",
	subreddit = "texas",
	sort_by = "new",
	cn_threshold = 1,
	page_threshold = 10
)


#We can use View( ) to look at the data.


View (links)


#This line of code can be used to directly scrape a URL by using 
#"URL = "reddit.com/...." or can be used to scrape from a dataset. This 
#can be used in conjunction with the reddit_urls( ) function to gather 
#URLs and then acquire all content from those URL. 
#In the below example, I am scraping a single row from the links dataset.
#In this case, it is the 17th row, but if I were to have the code read 
#"reddit_content(links$URL)", then all URLs would be scraped rather than 
#the single specified one as below.


content <- reddit_content(links$URL[17])


#Again, we can use View ( ) to look at our dataset.


View (content)


#Finally, we can write the .csv files and save our data. You can 
#name your files however you want. Just change the name in the file = 
#command. You must always end your file name in .csv . 

write.csv (links, file = "links.csv")
write.csv (content, file = "content.csv")