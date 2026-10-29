import java.sql.*;
import java.util.Scanner;

public class Main {
    private static final String URL = "jdbc:mysql://localhost:3306/calzados_sa";
    private static final String USUARIO = "root";
    private static final String CONTRASEÑA = "root";
    
    public static void main (String[] args)
    {
        try (Connection conn = DriverManager.getConnection(URL, USUARIO, CONTRASEÑA) ; Scanner sc = new Scanner(System.in) )
        {
            Gestionable gestorProveedor = new GestionarProveedor();
            int opcion = -1;

            while (opcion != 0)
            {
                System.out.println();
                System.out.println();
                System.out.println();
                System.out.println();
                System.out.println();

                try {opcion = Integer.parseInt(sc.nextLine());
                } catch (NumberFormatException e) {
                    System.out.println("Ingrese un numero valido");
                    continue;
                }

                switch (opcion) {
                    case 1: gestorProveedor.insert(conn, sc);
                    case 2: gestorProveedor.delete(conn, sc);
                    case 3: gestorProveedor.printAll(conn);
                    case 4: continue;
                    case 0: System.out.println("Terminando programa");
                    default: System.out.println("No existe esa opcion");
                }
            }
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        }
    }

    private static void consultaSQL(Connection conn, Scanner sc)
    {
        System.out.println();
        System.out.println();
        System.out.println();

        String query = sc.nextLine().trim();
        if (query.isEmpty())
        {
            System.out.println("Sentencia vacia");
            return;
        }

        try (Statement statement = conn.createStatement() )
        {
            // Retorna TRUE si fue una consulta
            boolean isSelectQuery = statement.execute(query);
            if (isSelectQuery)
            {
                try (ResultSet tuplas = statement.getResultSet() )
                {
                    ResultSetMetaData metadata = tuplas.getMetaData();
                    int columnas = metadata.getColumnCount();
                    int totalTuplas = 0;
                    while (tuplas.next() )
                    {
                        System.out.println("-----------------------------------");
                        for (int i = 1; i <= columnas; i++)
                        {
                            Object atributo = tuplas.getObject(i);
                            String nombreColumna = metadata.getColumnLabel(i);
                            String atributoAux = atributo != null ? atributo.toString() : "NULL";
                            System.out.println(nombreColumna + " = " + atributoAux);
                            totalTuplas++;
                        }
                        System.out.println("-----------------------------------");
                        System.out.println("Cantidad de tuplas retornadas = " + totalTuplas);
                    }
                } catch (SQLException e) {
                    System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
                }
            }
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        }
    }
}
