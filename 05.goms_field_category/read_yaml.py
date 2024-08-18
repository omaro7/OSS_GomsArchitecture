import yaml
import os
import sys

def flatten_dict(d, parent_key='', sep='_'):
    items = []
    for k, v in d.items():
        new_key = f"{parent_key}{sep}{k}" if parent_key else k
        if isinstance(v, dict):
            items.extend(flatten_dict(v, new_key, sep=sep).items())
        else:
            items.append((new_key, v))
    return dict(items)

def load_yaml(file_path):
    with open(file_path, 'r') as stream:
        try:
            return yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(exc)
            return None

def main():
    if len(sys.argv) != 2:
        print("Usage: python read_yaml.py <yaml_file>")
        sys.exit(1)

    yaml_file = sys.argv[1]
    config = load_yaml(yaml_file)
    
    if config is None:
        sys.exit(1)

    # workspace
    workspace_config = flatten_dict(config.get('workspace', {}))
    for key, value in workspace_config.items():
        os.environ[f"workspace_{key}"] = str(value)
        print(f"set workspace_{key}={value}")

    # entity
    table = config.get('entity', {}).get('table', '')
    os.environ['entity_table'] = table
    print(f"set entity_table={table}")

    columns = config.get('entity', {}).get('colume', [])
    for i, col in enumerate(columns):
        name = col.get('name')
        alias = col.get('alias')
        type_ = col.get('type')
        if name and type_:
            os.environ[f"entity_colume_{i}_name"] = name
            os.environ[f"entity_colume_{i}_alias"] = alias
            os.environ[f"entity_colume_{i}_type"] = type_
            print(f"set entity_colume_{i}_name={name}")
            print(f"set entity_colume_{i}_alias={alias}")
            print(f"set entity_colume_{i}_type={type_}")

    select_columns = []
    for col in columns:
        name = col.get('name')
        alias = col.get('alias')
        if name and alias:
            select_columns.append(f"{name} as {alias}")

    select_statement = f"SELECT {', '.join(select_columns)} FROM {table}"
    os.environ[f"select_statement"] = select_statement
    print(f"set query={select_statement}")

    idxColumeName = columns[0].get('name');
    idxAliasName = columns[0].get('alias');

    get_statement =  f"SELECT {', '.join(select_columns)} FROM {table} WHERE {idxColumeName} = #{{{idxAliasName}}}"
    os.environ[f"get_statement"] = get_statement
    print(f"set query_one={get_statement}")

    del_statement =  f"DELETE FROM {table} WHERE {idxColumeName} = #{{{idxAliasName}}}"
    os.environ[f"del_statement"] = del_statement
    print(f"set query_del={del_statement}")

    set_statements = []

    for col in columns:
        name = col.get('name')
        alias = col.get('alias')
        if name and alias:
            set_statements.append(f"{name} = #{{{alias}}}")

    set_clause = ", ".join(set_statements)
    update_statement = f"UPDATE {table} SET {set_clause} WHERE #{{{idxAliasName}}}"
    os.environ[f"update_statement"] = update_statement
    print(f"set query_upd={update_statement}")

    column_names = []
    column_values = []

    for col in columns:
        name = col.get('name')
        alias = col.get('alias')
        if name and alias:
            column_names.append(name)
            column_values.append(f"#{{{alias}}}")

    columns_clause = ", ".join(column_names)
    values_clause = ", ".join(column_values)
    insert_statement = f"INSERT INTO {table} ^({columns_clause}^) VALUES ^({values_clause}^)"
    os.environ[f"insert_statement"] = insert_statement
    print(f"set query_ins={insert_statement}")

if __name__ == "__main__":
    main()