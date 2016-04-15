# Performance Foundamentals

### Useful Performance Testing Tools

1. Apache Bench - Benchmark http request and response time

2. Bullet - https://github.com/flyerhzm/bullet , To analyse N+1 problems

3. Rack-Mini-Profile - Show page loading time on the page

4. FlameGraph - Graphic to monitor the performance of loading a page

5. Rails Panel -  A ghrome plugin 

6. `Benchmark.realtime { ModelName.all.each {} }` it will give you the total time run execute the method in the block

7. `ps -o pid,rss,command`  to display the memeory consuming status of the processes

8. Lol_dba is a gem which can help checking index of all tables 
 
### Techniques

1. Eager loading

2. Nature SQL replacing ruby code

3. Upgrate ruby version

4. Instead of selecting all columns of a table, select column ONLY YOU NEED

5. `AR.pluck(&:column_name)` is better than `AR.all.map(&:column_name)` 

6. `ModelName.find_each` has better memory performance than `ModdelName.each`

7. Http Header
  * Last-Modified/If-Modified-Since
  * Etag/If-None-Match
  * Cache-Control:max-age

8. Rack::ETag

9. stale? and fresh_when

10. Update associated objects which is trgged by updated_at, add `has_many/has_one/belongs_to` touch:true 

11. Include session data in Etag

12. Declarative Etag 

13. Reset Etags on deploy for HTML or CSS changes

14. expires_in 

###Turbolinks and Pjax

1. A jquery plugin to solve the turbolinks document ready issue - **jquery-turbolinks**
   * Add this line of code into application.js file
    ```
     //= require jquery.turbolinks
    ```

2. Bind $(document) outside of $(document).ready

3. `<script data-turbolinks-eval=false>`

4. `data-no-turbolinks`

===
