LOCViewer (Library of Congress Viewer)
=========
An example project using:

*   [Mantle](https://github.com/github/Mantle)
*	[AFNetworking](https://github.com/AFNetworking/AFNetworking)
*	[Overcoat](https://github.com/gonzalezreal/Overcoat)
*	[SDWebImage](https://github.com/rs/SDWebImage)
*	[SVPullToRefresh](https://github.com/samvermette/SVPullToRefresh)

LOCViewer currently searchs the Library of Congress - Prints and Photographs Online Catalog API, then simply displays the response as a table of cells, each containing a picture.

The search result is paginated, with each page/result containing 20 pictures. When the user scrolls to the bottom of the table, a query for the next page is executed, with the response data being inserted into the table.
