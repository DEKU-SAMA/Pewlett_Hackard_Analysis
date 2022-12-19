# Pewlett_Hackard_Analysis
# Overview of the Analysis
Pewlett Hackard is established as a company with growing portion of it's employee base entering retirment age at the start of the module. The management team would like 
to identify this group of individuals in order to prepare for the upcomming "Silver Tsunami". Other questions the team is interested in understanding include:

What is the total size of the group?
Which Departments are at Risk to Lose the Most Employees?
How many of the Eligible Retirees are Mentors?
What are the Titles of the Retirees?
Which Current Employees should be mentored to fill vacancies from retired employees?

# Results
Running an initial search of the employees who are deemed in the age bracket for retirement reveals an surprisingly large list even for a company as big as Pewlett-
Hackard. There are over one hundred and thirty-three thousand names on this list and might cause a great deal of concern. After reviweing the table, we ntoticed that 
there were many duplicates littered throughout the data. This just means we need a more specific query to eliminate the chance for duplicates, which we do in the updated 
query. The updated query cut the list down to just over ninety thousand names.

# Original Query Output:
![retirement_titles](https://user-images.githubusercontent.com/109875421/208343523-4c7b477d-9de1-4563-abcf-7449672ef3ca.png)

# Updated Query Output:
![unique_titles](https://user-images.githubusercontent.com/109875421/208344503-64b8f885-4400-4760-b208-61be514a0b54.png)

The next query we made cretated a table of the number elgible retirees and their titles. Looking at the number of titles of the employees soon to retire, the 
overwhelming majority are in Senior Engineer and Senior Staff, and this is roughly two thirds of the company. This is a highly skilled group of individuals. We noticed 
that many on this list had been in more junior positions and been promoted, so also carry invaluable institutional knowledge. The rest of the group is split between four 
of the titles with only two managers on the list. While it does seem odd that more that managers are not on this list, we surmised that managers would be senior 
employees at the end of their career.

# Query Output: 
![unique_titles](https://user-images.githubusercontent.com/109875421/208346088-5e7d4a97-ab42-42a7-b5e2-317468448955.png)

The last and final query looks for employees who are still active with the company and a few years behind the retiring group. Ideally Hewlett-Packard would want to 
enroll all of these employees, with higher levels of experience, in a mentorship program with the retiring employees. This would be done in order to transfer some of 
that institutional knowledge to some of the more recent members of their company. This query looked for a pool born within a 1 year range. We would hope that this 
group would be at least 25%, if not more, of the size of the retiring group.

# Query Output: 
![mentorship_eligibility](https://user-images.githubusercontent.com/109875421/208347110-d3ceaa80-b390-4987-8670-03b02faad555.png)

The mentoring group is only 1500 in a 1 year period

# Summary
How many roles will need to be filled as the "silver tsunami" begins to make an impact?

If we take a look at the Retirement Title Count table, it clearly shows how many potential employees will be retiring from each position. This means, at some point in 
the near future, that many roles will need to be filled by new hires. However, if we modify the table, and query only active employees who have all the same criteria, 
we get a more accurate measure of the number of employees about to retire:

# Query Output:
![titles_to_be_filled](https://user-images.githubusercontent.com/109875421/208349654-536402ce-aeb8-40d7-85ab-04dddcabf0f8.png)

Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
This answer requires a new query, one to compile the count of all the eligible Mentors into a table grouped by title, to make a clear comparison to those employees who 
are retiring and will need their spots filled:

# Query Output:
![eligible_mentor_count](https://user-images.githubusercontent.com/109875421/208350168-6bf137a7-eb50-44a0-9c63-1d519a43ff5b.png)

Comparing this table to the more accurate retirement table, you can see that in a worst case scenario, where all of the retirement eligible employees quit at the same 
time, the eligible mentors could take on new hires at roughly a 2:1 to 3:1 ratio for senior staff and senior engineers. The ratios then jump quite drastically to 
around 14:1 for engineers, 13:1 for staff, 20:1 for technique leaders, and finally 8:1 for assistant engineers. Although, this is unlikely to occur, and with the given 
mentors, Pewlett-Hackard should have more than enough mentors to guide any new hires.
