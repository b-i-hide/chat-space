# Chat-space

## テーブル設計
### users table
|column|type|constraint|index|<br>
|:--|--:|:--:|:--:|<br>
|name|string|null&false, unique: true|◯|
### chat_groups table
|column|type|constraint|index|<br>
|:--|--:|:--:|:--:|<br>
|name|string|null&false|-|

### chat_group_users table
|column|type|constraint|index|<br>
|:--|--:|:--:|:--:|<br>
|user_id|reference|foreign_key: true|◯|
|chat_group_id|reference|foreign_key: true|◯|

### messages table
|column|type|constraint|index|<br>
|:--|--:|:--:|:--:|<br>
|body|text|-|-|
|image|string|-|-|
|user_id|reference|foreign_key: true|◯|
|chat_group_id|reference|foreign_key: true|◯|

## リレーション
### user
* has_many :chat_group_users
* has_many :messages
* has_many :chat_groups, through :chat_group_user

### chat_group
* has_many :chat_group_users
* has_many :messages
* has_many :users, through :chat_group_user

### chat_group_user
* belongs_to :user
* belongs_to :chat_group

### message
* belongs_to :user
* belongs_to :user
