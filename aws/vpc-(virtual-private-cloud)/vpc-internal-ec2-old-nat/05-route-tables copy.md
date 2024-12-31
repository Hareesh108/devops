
# VPC (Virtual Private Cloud)

Login aws account and search for VPC then select that service.

## Go to the VPC and Select create route table

- In the route table you will see there is default route table.
- But there you will not have ```Explicit subnet associations```.
- Crate two route tables.
- Name ``public-route-table``
- Select a VPC you created.
- Name ``private-route-table``
- Select a VPC you created.

## After creating two route tables

- Lets assign subnet to it accordingly.
- Select route table and select option: ```subnet associations```.
- Then assign the respective subnet.

### Routes table ```public-route-table```

- Select and go to ```Routes```. edit the routes.
- Add the route ```0.0.0.0/0```. and target select Internet Gateway and select Internet gateway you created.
