# Create a user
user = User.create(
  name: "John Doe",
  email: "john@example.com",
  password: "123456",
  role: "admin"
)

# Create multiple trades associated with the user
trades = [
    {
        name: "House Drilling",
        description: "Description of the trade",
        image: "https://mtcsolutions.com/wp-content/uploads/2021/06/Tips-Tricks_Banner.jpg",
        location: "Trade Location",
        price: 100.0,
        duration: "1 hour",
        trade_type: "Type of Trade",
        user: user,
        removed: false
    },
    {
        name: "Electrics",
        description: "Description of the trade",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIKI_8kVG5zFj6TL_gMjqU6-sJ6nZJgREUlw&usqp=CAU",
        location: "Trade Location",
        price: 100.0,
        duration: "1 hour",
        trade_type: "Type of Trade",
        user: user,
        removed: false
    },
    {
        name: "Wood DIY",
        description: "Description of the trade",
        image: "https://blog.acmetools.com/wp-content/uploads/2018/10/header-4.jpg",
        location: "Trade Location",
        price: 100.0,
        duration: "1 hour",
        trade_type: "Type of Trade",
        user: user,
        removed: false
    },
    {
        name: "Construction",
        description: "Description of the trade",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr6_JN29hmExNrHdl3WF8a-JyWvszIFvrkaw&usqp=CAU",
        location: "Trade Location",
        price: 100.0,
        duration: "1 hour",
        trade_type: "Type of Trade",
        user: user,
        removed: false
    },
    {
        name: "Heavy Lifting",
        description: "Description of the trade",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnY5ERcwhCdswfOGd68TOtTwolxqV6T0NIVA&usqp=CAU",
        location: "Trade Location",
        price: 100.0,
        duration: "1 hour",
        trade_type: "Type of Trade",
        user: user,
        removed: true
    }
]

Trade.create(trades)
