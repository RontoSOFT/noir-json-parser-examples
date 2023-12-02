use dep::rontosoft::JSON;

global json_string =
r#"
{
    "name": "John Doe",
    "age": 30,
    "isEmployed": true,
    "pin": [1, "2", false],
    "salary": 50000.75,
    "address": "0xd8da6bf26964af9d7eed9e03e53415d37aa96045",
    "location":
    {
        "state": "Arizona",
        "code": "AZ"
    }
}"#;

unconstrained
fn employed_and_over_thirty(json : JSON) -> bool
{
    let is_employed = json.get_bool("isEmployed").unwrap();
    let age = (json.get_field("age").unwrap() as u8);

    (is_employed & (age > 30))
}

unconstrained
fn valid_address(json : JSON) -> bool
{
    let address = json.get_string("address");

    if (address.len() == 42) { (address[0] == 0x30) & (address[1] == 0x78) } /* "0x" */ else { false }
}

unconstrained
fn valid_location(json : JSON) -> bool
{
    let object = json.get_object("location");

    (object.get_string("state").eq_string("Arizona") & (object.get_field("code").unwrap() == 41))
}

unconstrained
fn perform_business_logic<N>(string : str<N>)
{
    let json = string.as_json();

    assert(json.get_string("name").eq_string("John Doe") == true);
    assert(valid_address(json) == true);
    assert(employed_and_over_thirty(json) == false);
}

#[test]
unconstrained
fn test_business_logic()
{
    perform_business_logic(json_string);
}

fn main(string : str<10000>)
{
    perform_business_logic(string);
}
