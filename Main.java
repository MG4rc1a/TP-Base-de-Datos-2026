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
                System.out.println("#####################################");
                System.out.println("Opciones = ");
                System.out.println("1 - Insertar proveedor");
                System.out.println("2 - Remover proveedor");
                System.out.println("3 - Printear todos los proveedores");
                System.out.println("4 - Consultas generales");
                System.out.println("");
                System.out.println("Consultas predefinidas:");
                System.out.println("5 - [6.a]");
                System.out.println("6 - [6.b]");
                System.out.println("7 - [6.c]");
                System.out.println("8 - D");
                System.out.println("9 - E");
                System.out.println("10 - F");
                System.out.println("11 - G");
                System.out.println("0 - Terminar programa");
                System.out.println("#####################################");

                try {opcion = Integer.parseInt(sc.nextLine());
                } catch (NumberFormatException e) {
                    System.out.println("Ingrese un numero valido");
                    continue;
                }

                switch (opcion) {
                    case 1: gestorProveedor.insert(conn, sc); break;
                    case 2: gestorProveedor.delete(conn, sc); break;
                    case 3: gestorProveedor.printAll(conn); break;
                    case 4: comandoSQL(conn, sc); break;
                    case 5: comandoSQL(conn, PredefinedQuerys.CONSULTA_A); break;
                    case 6: comandoSQL(conn, PredefinedQuerys.CONSULTA_B); break;
                    case 7: comandoSQL(conn, PredefinedQuerys.CONSULTA_C); break;
                    case 8: comandoSQL(conn, PredefinedQuerys.CONSULTA_D); break;
                    case 9: comandoSQL(conn, PredefinedQuerys.CONSULTA_E); break;
                    case 10: comandoSQL(conn, PredefinedQuerys.CONSULTA_F); break;
                    case 11: comandoSQL(conn, PredefinedQuerys.CONSULTA_G); break;
                    case 0: System.out.println("Terminando programa..."); break;
                    default: System.out.println("No existe esa opcion"); break;
                }
            }
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s\n", e.getSQLState(), e.getMessage());
        }
    }

    private static void comandoSQL(Connection conn, Scanner sc)
    {
        System.out.println("Inserte un comando SQL valido (SELECT, INSERT, DELETE...)\n");
        String query = sc.nextLine().trim();
        comandoSQL(conn, query);
    }
    private static void comandoSQL(Connection conn, String query)
    {
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
                        totalTuplas++;
                        System.out.println("-----------------------------------");
                        for (int i = 1; i <= columnas; i++)
                        {
                            Object atributo = tuplas.getObject(i);
                            String nombreColumna = metadata.getColumnLabel(i);
                            String valorAtributo = atributo != null ? atributo.toString() : "NULL";
                            System.out.println(nombreColumna + " = " + valorAtributo);
                        }
                        System.out.println("-----------------------------------");
                    }
                    System.out.println("Cantidad de tuplas retornadas = " + totalTuplas);
                } catch (SQLException e) {
                    System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
                }
            } else {
                int tuplas_afectadas = statement.getUpdateCount();
                String respuesta = (tuplas_afectadas > 0) ? (tuplas_afectadas + " tuplas afectadas") : "No se ha afectado a ninguna tupla";
                System.out.println(respuesta);
            }
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s\n", e.getSQLState(), e.getMessage());
        }
    }
}
