Each time you git pull:
  step 1 => rake db:migrate => for setting up development database
  step 2 => rake db:migrate RACK_ENV=test  => for setting up test database

iteration 1 steps 4 success:
  1. change the payload request test -DDD
  2. run the test, deal with the first error;
        a. create the model test indicated
        b. create the model needed
        c. create the table migration needed
             1. create table
             2. delete column
             3. add column
        d. make the model test pass.
        e. make that line of the payload_request_test pass.
  3. deal with the next line
  4. repeat until the payload request test passes.

iteration 2 notes:

  methods needed:
    1. Average Response time for our clients app across all requests
      #class method on PayloadRequest, sum all response times and divide by the number of requests
    2. Max Response time across all requests
      #class method on PayloadRequest; select all response times, get the MAX
    3. Min Response time across all requests
      #class method on PayloadRequest; MIN
    4. Most frequent request type
      #class method on RequestType; MAX
    5. List of all HTTP verbs used
      #class method on RequestType; FETCH.uniq ??
    6. List of URLs listed from most requested to least requested
      #class method on Url? or maybe PayloadRequest; ORDER? desc?
    7. Web browser breakdown across all requests(userAgent)
      #class method on UserAgent; I don't know what this means tho.
    8. OS breakdown across all requests(userAgent)
      #class method on UserAgent; I don't know what this means tho, again.
    9. Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
      #class method on Resolution; FETCH ?
    10. Events listed from most received to least.
      #class method on EventType or maybe PayloadRequest; ORDER? desc?
  URL instance methods needed: 
    1.  Max Response time
      #instance method; select response times and MAX
    2.  Min Response time
      #instance method; select response times and MIN
    3.  A list of response times across all requests listed from longest response time to shortest response time.
      #instance method; select response times and order little to big (reg. ORDER)
    4.  Average Response time for this URL
      #instance method; sum response times and div by count of requests
    5.  HTTP Verb(s) associated with this URL
      #instance method; FETCH.uniq ??
    6.  Three most popular referrers
      #instance method; use order(desc) then take(3)
    7.  Three most popular user agents. We can think of a 'user agent' as the combination of OS and Browser.
      #same as above
