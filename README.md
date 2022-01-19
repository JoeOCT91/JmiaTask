# ptc_ios_test

# frameWorks 

- UIKit
- Combine
- Foundation

# 3rd party frameworks 

- Alamofire "to handle netWork calls and decode Date"
- combineCocoa "make combine work way better with UIKit elements"
- swiftGen "to control resources and organise it in a way make modifications way more easy"
- Cosmos "to handle rating views" 


# Description:

The architecture used to build this project is MVVM-C, data binding and reactive programing archived using combine framework as native framework created by apple  for more stability, speed and support in future, high priority goes for code structure and functionality then the UIDesign, the UI and auto-layout achieved via pure code no use for storyboards.     

The project contains the following:

1. The splash screen
    - It's a loading page to request and save some configurations to be used. 

2. The search page: 
    - It's a page that allow submit a query to get a result, like Google Search.

3. The result list page:
    - It's a page that shows the query and respective result, like Google Search.
    - Reaching the bottom loads the next page (pagination). 
    - For each result item should be displayed this information:
        - Image; 
        - Name and brand;
        - Price, old price and discount;
        - Rating;

4. The item detail page:
    - It's a page that shows the information about the selected item.
    - Should be displayed this information:
        - Image or image gallery;
        - Name and brand;
        - Price, old price and discount;
        - Rating;
        - Description
        
