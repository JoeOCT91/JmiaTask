# ptc_ios_test


![alt tag](screen-porto-tech-center.jpg)

Jumia Porto Tech Center (PTC) is an Agile IT development center, with around 200 IT-specialists, 
where you will have the opportunity to participate in developing smart solutions for our group companies. 
We do e-commerce shops, logistics, business intelligence and mobile applications involving a wide range of high-end technologies for tens of millions customers.  

You can check our job opportunities at our site: https://group.jumia.com/careers.  

We were founded in 2012 and today we are part of Jumia Group powered by Rocket Internet, Millicom, MTN, Axa Group, 
Goldman Sachs, Orange and CDC.   Working at PTC means being in the first line of e-commerce development in emerging markets.  

What you will find in PTC?  

In PTC you will have an opportunity to develop and apply e-business software solutions for a wide range of business areas. 

You will belong to the international team with the top experts who will inspire and support you in working on an international scale impacting millions of revenue (travelling, logistics, e-shops) and users. 

We are humble and pragmatic. 

We are passionate about what we do, and we have fun while doing it. 

We move in a fast-pace and we are ready to challenge risks. 

We value sharing knowledge and learning from each other. We are flexible and we believe that anything is possible. 

We will offer you second home where you will find the opportunity for growth and career development.
You will have the opportunity to earn the bonus based on your excellent results. 
The benefit list includes but is not limited to health insurance, parental bonus, snacks and fruits.

This repo represents the current admission test that is needed to apply for an iOS Developer Position.

iOS Challenge:
-

The idea is create an app that is able to list items requested by a query. 

The challenge submission:
- Create a pull request using the base "development_mocklab" 
- Title format "Challenge Admission Test - FIRST_NAME LAST_NAME"
- Write a description about your implementation

Description:
-

The application should be composed by:

    - Splash screen 
    - Search page 
    - Result list page 
    - Item detail page

The following requirements need to be met:

The search must be able to list items from a certain actor or director.

1. The splash screen:
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
        - Description;


Mock API:
-

NOTE: The mocklab API is based in JSON mocks, only supports the following requests.

- Get configurations

    > http://nd7d1.mocklab.io/configurations/
    
    The currency should used to format the price and old price.

- Get list items with pagination

    > http://nd7d1.mocklab.io/search/phone/page/1/
    
    > http://nd7d1.mocklab.io/search/phone/page/2/

    Paremeters:
    - *"phone"* - the query
    - *"1"* - the page number (pagination)

- Get detail item

    > http://nd7d1.mocklab.io/product/1/

    > http://nd7d1.mocklab.io/product/2/

    Paremeters:
    - *"1"* - the product identifier "sku"
    
    
- Failure cases

    HTTP 200 - Success false:
    > http://nd7d1.mocklab.io/product/3/
    
    HTTP 404 - Not Found:
    > http://nd7d1.mocklab.io/search/phone/page/2/
    
    > http://nd7d1.mocklab.io/product/4/


Required tech implementations:
-
- MVVM;
- Swift;
- AutoLayout with Constraints;
- Material Design Components;


We value the following implementations:
-
- Reactive Programming;
- Data Binding;
- Animations;
- Image Loader;
- API communication;

