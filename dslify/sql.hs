import Data.List

data Table = Table String
  deriving Show
data Column = Column Table String
  deriving Show
data Clause = Equals Column Column
  deriving Show
data Select = Select [Column] [Table] [Clause]
  deriving Show

example = Select [user_name,user_birthday] [users,accounts] [Equals user_id account_id]
 where users = Table "Users"
       accounts = Table "Accounts"
       user_id = Column users "id"
       account_id = Column accounts "id"
       user_birthday = Column users "birthday"
       user_name = Column users "name"

render_select (Select columns tables clauses)
  = "Select " ++ columns_render ++ " from " ++ tables_render ++ " where " ++ clause_render
    where columns_render = concat (commaSepererate (map render_column columns))
          tables_render = concat (commaSepererate (map render_table tables))
          clause_render = concat (commaSepererate (map render_clause clauses))

render_column (Column table column_name) = render_table table ++ "." ++ column_name
render_table (Table table_name) = table_name
render_clause (Equals c1 c2) = render_column c1 ++ "=" ++ render_column c2
commaSepererate = intersperse ","

{-
main = do
       user <- table "Users"
       account <- table "Accounts"
       restrict (lookup user "id" `equals` lookup account "id")
       project (lookups user ["name","birthday"])

   => select name,birthday from users,accounts where user.id = account.id
 -}
