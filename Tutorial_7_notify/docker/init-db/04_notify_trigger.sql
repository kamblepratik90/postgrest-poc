CREATE or REPLACE FUNCTION api.notify_trigger() RETURNS trigger AS $$
DECLARE
  BEGIN
    PERFORM pg_notify(CAST('my_channel' AS text), row_to_json(NEW)::text);
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER nto_table_update_trigger
  AFTER INSERT OR UPDATE OR DELETE ON api.todos
  FOR EACH ROW EXECUTE PROCEDURE api.notify_trigger();


--   DROP TRIGGER nto_table_update_trigger ON api.todos;

-- conditional trigger
--  WHEN (OLD.done IS DISTINCT FROM NEW.done) 
