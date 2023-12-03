# Introduction

Greetings!

Behold, a compendium of instances illustrating the utilization of the illustrious [`noir-json-parser`](https://github.com/RontoSOFT/noir-json-parser) library. This dear reader, is your ticket to navigating the cosmos of JSON parsing with the finesse of a Vogon poetry enthusiast. So grab a towel, embrace the absurdity, and embark on this interstellar journey through the wonders of code in [Aztec](https://docs.aztec.network/)'s 🌌[Noir](https://noir-lang.org/) ZK-rollup galaxy of data.

<br>

# Table of Contents
- [Setup](#setup)
- [Thinking JSON in Noir](#thinking-json-in-noir)
    - [`object`](#object)
    - [`array`](#array)
    - [`string`](#string)
    - [`number`](#number)
    - [`literal`](#literal)
    - [`single value`](#singe-value)

<br>

# Setup

<br>

Refer to the `noir-json-parser` [setup instructions](https://github.com/RontoSOFT/noir-json-parser/blob/main/README.md#setup).

<br>
<br>

# Thinking JSON in Noir

<br>

- <a id="object"></a> **`object`** values are surrounded with braces `{` `}` and are represented as a slice of `Property` instances

    ```json
    { "a": 10, "b": true }
    ```
    will be represented as
    ```rust
    [
        Property { key: "a".as_bytes(), value : "10".as_bytes() },
        Property { key: "b".as_bytes(), value : "true".as_bytes() }
    ]
    ```
    accessed via
    ```rust
    // returns "1" as [u8] instance
    json.get("a");
    json.doc[0].value;

    // returns "true" as [u8] instance
    json.get("b");
    json.doc[1].value;

    // convert to native types

    // returns "10" as Option<Field>
    json.get_field("a");
    json.get("a").as_field();
    json.doc[0].value.as_field(); // returns Option<Field>

    // returns "true" as Option<bool>
    json.get_bool("b");
    json.get("b").as_bool();
    json.doc[1].value.as_bool();
    ```

    <br>

    A child object
    ```json
    { "a": 10, "b": { "c": "I'm a child object" } }
    ```
    will also be represented as a list of `Property` instances in the `doc` property
    ```rust
    [
        Property { key: "a".as_bytes(), value : "10".as_bytes() },
        Property { key: "b".as_bytes(), value: "{0}".as_bytes() } // 0 here is the actual byte value of 0, not the string "0" (0x30)
    ]
    ```
    and hold the child object in the parent `JSON` instance" `children` property

    ```rust
    [
        [
            Property { key: "c".as_bytes(), value : "I'm a child object".as_bytes() }
        ]
    ]
    ```

    accessed via

    ```rust
    json.get_object("b"); // return a JSON instance via key search
    json.child(0);        // return a JSON instance by child index
    ```

<br>
<br>

- <a id="array"></a> **`array`** values are surrounded with brackets `[` `]`

    ```json
    { "a" : "[1,2,3]" }
    ```

    will be represented as

    ```rust
    Property { key: "a".as_bytes(), value : "[1,2,3]".as_bytes() }
    ```

    accessed via

    ```rust
    // returns [1,2,3] as [u8] instance
    json.get("a")
    json.doc[0].value;

    // convert [1,2,3] to array-list [[u8]]
    json.get_array("a");
    json.get("a").as_list()
    json.doc[0].value.as_list();
    ```

<br>
<br>

- <a id="string"></a> **`string`** values are surrounded with quotation marks `"` `"`

    ```json
    { "a": "my string" }
    ```

    will be represented as

    ```rust
    Property { key: "a".as_bytes(), value : "\"my_string\"".as_bytes() }
    ```

    accessed via

    ```rust
    // returns "my_string" as [u8] instance
    json.get("a");
    json.doc[0].value;

    // convert "my_string" to my_string (without quotes) as [u8]
    json.get_string("a");
    json.get("a").as_string();
    json.doc[0].value.as_string(); // returns my_string (without quotes) instance as [u8]
    ```

<br>
<br>

- <a id="number"></a> **`number`** values are stored as they appear

    ```json
    { "a": 123e+01 }
    ```

    will be represented as

    ```rust
    Property { key: "a".as_bytes(), value : "123e+01".as_bytes() }
    ```

    accessed via

    ```rust
    // returns "123e+01" as [u8] instance
    json.get("a")
    json.doc[0].value;

    // returns value of key "a", which is "1230", as Option<Field>
    json.get_field("a");
    json.get("a").as_field();
    json.doc[0].value.as_field();
    ```

<br>
<br>

- <a id="literal"></a> **`literal`** values are stored as they appear

    ```json
    { "a": true }
    ```

    will be represented as

    ```rust
    Property { key: "a".as_bytes(), value : "true".as_bytes() }
    ```

    accessed via

    ```rust
    // returns "true" as [u8] instance
    json.get("a")
    json.doc[0].value;

    // returns value of key "a", which is "true", as Option<bool>
    json.get_bool("a");
    json.get("a").as_bool();
    json.doc[0].value.as_bool();
    ```

<br>
<br>

- <a id="single-value"></a> **`single values`** are stored with an empty key

    ```json
    true
    ```
    will be represented as
    ```rust
    Property { key: "".as_bytes(), value : "true".as_bytes() }
    ```
    accessed via
    ```rust
    // returns value of true as Option<bool>
    json.get_bool("");
    json.get("").value.as_bool();
    json.doc[0].value.as_bool();
    ```

<br>
<br>

# Contributing

Get in touch with the owners via [Noir Discord](https://discord.gg/JtqzkdeQ6G) to get approved as a collaborator.

Use the hashtag `noir-json-parser`.
