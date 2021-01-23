# README
 Mealswipe is an application that allows you to search for restaurants and swipe through photos like a dating site.

## Installation

- Ensure that you have [Ruby](https://www.ruby-lang.org/en/downloads/) installed properly
- Begin by cloning the repository and navigating to the download location
- Make sure that you have all necessary gems by running:

```
bundle install
```

- Run the migrations

```
rails db:migrate
```
## Usage

### Starting the program

To start the application:

```
rails s
```

Navigate in your web browser to the address listed in:

```
Listening on http://127.0.0.1:3000
```

In this case, it would be `http://127.0.0.1:3000`

### How to use the program

- The application opens on the homepage. From here, you may:
  - Begin the Login process by selecting what kind of account you wish to login to
    - Then, either fill out the form to login or click the button to sign in (or create new account) with Facebook Omniauth
- Upon successfully signing in or registering, you will be brought to your profile page where you can see all your Albums(if you have any), the button to create a new Album, and the buttons to edit or delete your profile
- From here you may navigate to view many things, such as:
  - Swipe - Where you can enter a city or zipcode and an API call will be made to yelp.  From there random photos of restaurants in your area will be displayed.  Swipe left or right and discover something new to eat in your area.
  - Your Profile
  - Logout: You will be logged out of Take Your Pix

## License

The program is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)

## Collaborating

Pull Requests are welcome on [GitHub](https://github.com/rebeccahickson/cowboy-up). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://github.com/cjbrock/worlds-best-restaurants-cli-gem/blob/master/contributor-covenant.org) code of conduct.
