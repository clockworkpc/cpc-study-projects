# Comparison of Solutions to Models with Overlapping Attributes

## Conclusion

I believe that the best solution for our use-case is delegated types:
1. It is the least disruptive to existing data.
2. It is the DRYest way of distinguishing between uploaded files in both Models and tables.
3. It best facilitates the creation and modification of content-type-specific Models, without redundant migrations.

## Definitions

| Term            | The way it works in Rails                                                             |
|-----------------|---------------------------------------------------------------------------------------|
| Pure STI        | Parent + table (all attributes) > abstract Child.                                                      |
| Rails STI       | Parent + table (all attributes + "type") > abstract Child.                                   |
| MTI             | Abstract Parent > Child + table (all attributes for each)                                                       |
| Delegated Types | "Interface" + table (general attributes) <> "Implement" + table (specific attributes) |

## Comparison

Pure STI is not included because Rails STI addresses its most obvious defect.

| Problem                 | Rails STI | MTI | Delegated Types |
|-------------------------|-----------|-----|-----------------|
| Redundant columns?      | YES       | NO  | NO              |
| Cumbersome assocations? | MAYBE     | YES | NO              |
| Rigid attributes        | YES       | NO  | NO              |

## Our Use-case: Uploads vs Videos

We want to record uploaded files — images, audio, PDFs, and video — in a way that allows us to differentiate between content types whilst preserving each record's access to attributes and assocations.

To date, all Uploads have had the same attributes, but with the addition of hosted video, we will have an Upload with extra, specific attributes.

The `uploads` table contains the following attributes:

| type       | name    |
|------------|---------|
| string     | name    |
| references | project |

### Rails STI

**SUMMARY:** It could work but would require the addition of numerous null records to the `uploads` table.

In order to add the `Video` Model, the `uploads` table would have to be expanded as follows, at minimum:

| type               | name                                       |
|--------------------|--------------------------------------------|
| string             | name                                       |
| references         | project                                    |
| project_id         | bigint [ref: > projects.id, not null]      |
| organization_id    | bigint [ref: > organizations.id, not null] |
| user_id            | bigint [ref: > users.id, not null]         |
| cloudflare_details | jsonb [null, unique]
| deleted_by         | bigint [ref: > users.id, null]             |

And if `cloudflare_details` are unpacked:

| type                         | name                                       |
|------------------------------|--------------------------------------------|
| string                       | name                                       |
| references                   | project                                    |
| project_id                   | bigint [ref: > projects.id, not null]      |
| organization_id              | bigint [ref: > organizations.id, not null] |
| user_id                      | bigint [ref: > users.id, not null]         |
| cloudflare_uid               | string [unique, null, default: null]       |
| cloudflare_preview_url       | string [unique, null, default: null]       |
| cloudflare_thumbnail_url     | string [unique, null, default: null]       |
| cloudflare_stream_ready      | boolean [default: false]                   |
| cloudflare_status            | enum [default: 'downloading']              |
| cloudflare_meta              | jsonb [null, default: null]                |
| cloudflare_playback_hls_url  | string [null, unique]                      |
| cloudflare_playback_dash_url | string [null, unique]                      |
| deleted_by                   | bigint [ref: > users.id, null]             |

### Multiple Table Inheritance

**SUMMARY:** It would require the duplication of columns in the `videos` table, and for any other Child model's table thereafter.

In order to add the `Video` Model, the `videos` table would have to include all the columns from `uploads`.

| type                         | name                                       |
|------------------------------|--------------------------------------------|
| string                       | name                                       |
| references                   | project                                    |

In addition to video-specific attributes:

| type                         | name                                       |
|------------------------------|--------------------------------------------|
| project_id                   | bigint [ref: > projects.id, not null]      |
| organization_id              | bigint [ref: > organizations.id, not null] |
| user_id                      | bigint [ref: > users.id, not null]         |
| cloudflare_uid               | string [unique, null, default: null]       |
| cloudflare_preview_url       | string [unique, null, default: null]       |
| cloudflare_thumbnail_url     | string [unique, null, default: null]       |
| cloudflare_stream_ready      | boolean [default: false]                   |
| cloudflare_status            | enum [default: 'downloading']              |
| cloudflare_meta              | jsonb [null, default: null]                |
| cloudflare_playback_hls_url  | string [null, unique]                      |
| cloudflare_playback_dash_url | string [null, unique]                      |
| deleted_by                   | bigint [ref: > users.id, null]             |

This would not be difficult to implement, but if we need to add, delete, or modify an attribute that applies to all uploaded files, we'd need a migration and possibly a code change for every Model and table.

## Delegated Types

**SUMMARY:** This seems to fit the bill.  The only downside I can point to is we might need to add custom methods to the Models and possibly make some changes in Graphql.

In order to add the `Video` Model:
1. The `Upload` Model would need a `delegate_type` association to make it something like a Java interface to `Video`. (one line)
2. The `Video` Model would have to be associated with `Upload` by `has_one :upload, as: :uploadable`. (one line)

In the database:
1. The `uploads` table would be unchanged.
2. The `videos` table would include only video-specific attributes.
