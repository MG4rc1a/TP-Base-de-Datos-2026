import java.sql.*;
import java.util.Scanner;

public interface Gestionable {
    /*
    Inserta una tupla en una tabla de la base de datos
     */
    void insert (Connection conn, Scanner sc) throws SQLException;
    {
        System.out.println("Insertar CUIT:");
        String cuit = sc.nextLine();
        System.out.println("Insertar Razon Social:");
        String razon_social = sc.nextLine();
        System.out.println("Insertar Direccion:");
        String direccion = sc.nextLine();
        System.out.println("Insertar Telefono Fijo:");
        String tel_fijo = sc.nextLine();

        String query = "INSERT INTO proveedor (CUIT, razon_social, direccion, telefono_fijo) VALUES (?, ?, ?, ?)";
         try (PreparedStatement statement = connection.prepareStatement(query))
        {
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        }
        return;
    }
    /*
    Remueve una tupla en una tabla de la base de datos
     */
    void delete (Connection conn, Scanner sc) throws SQLException;
    /*
    Retorna todas las tuplas de la BD
     */
    void printAll (Connection conn) throws SQLException;
}