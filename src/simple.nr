use dep::rontosoft::JSON;

global json_string =
r#"
[
    {
        "id": 1,
        "first_name": "Jeanette",
        "last_name": "Penddreth",
        "email": "jpenddreth0@census.gov",
        "gender": "Female",
        "ip_address": "26.58.193.2"
    },
    {
        "id": 2,
        "first_name": "Giavani",
        "last_name": "Frediani",
        "email": "gfrediani1@senate.gov",
        "gender": "Male",
        "ip_address": "229.179.4.212"
    },
    {
        "id": 3,
        "first_name": "Noell",
        "last_name": "Beax",
        "email": "nbea2@imageshack.us",
        "gender": "Female",
        "ip_address": "180.66.162.255"
    },
    {
        "id": 4,
        "first_name": "Willard",
        "last_name": "Valek",
        "email": "wvalek3@vk.com",
        "gender": "Male",
        "ip_address": "67.76.188.26"
    }
]"#;

unconstrained
fn is_authorized<N, M>(json : JSON, firstName: str<N>, lastName: str<M>) -> bool
{
    let mut result = false;

    let array = json.get_array("");
    for element in array
    {
        let object = json.child(element[1]);

        let first_name = object.get_string("first_name");
        let last_name = object.get_string("last_name");

        if (!result & (firstName.eq(first_name) & lastName.eq(last_name)))
        {
            result = true;
        }
    }

    result
}

unconstrained
fn perform_business_logic<N>(string : str<N>)
{
    let json = string.as_json();

    assert(is_authorized(json, "Noell", "Beax") == true);
}

#[test]
fn test_business_logic()
{
    perform_business_logic(json_string);
}

fn main(string : str<10000>)
{
    perform_business_logic(string);
}
