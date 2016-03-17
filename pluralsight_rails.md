# Performance Foundamentals

### Useful Performance Testing Tools

1. Apache Bench - Benchmark http request and response time

2. Bullet - https://github.com/flyerhzm/bullet , To analyse N+1 problems

3. Rack-Mini-Profile - Show page loading time on the page

4. FlameGraph - Graphic to monitor the performance of loading a page

5. Rails Panel -  A ghrome plugin 

### Techniques

1. Eager loading

2. Nature SQL replacing ruby code

3. Upgrate ruby version

4. Instead of selecting all columns of a table, select column ONLY YOU NEED

5. `AR.pluck(&:column_name)` is better than `AR.all.map(&:column_name)` 

6. 

