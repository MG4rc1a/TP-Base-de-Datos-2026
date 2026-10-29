import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class GestionarProveedor implements Gestionable {

    @Override
    public void insert(Connection conn, Scanner sc) {
        System.out.println("Insertar CUIT:");
        String cuit = sc.nextLine();
        System.out.println("Insertar Razon Social:");
        String razon_social = sc.nextLine();
        System.out.println("Insertar Direccion:");
        String direccion = sc.nextLine();
        System.out.println("Insertar Telefono Fijo:");
        String tel_fijo = sc.nextLine();

        String query = "INSERT INTO proveedor (CUIT, razon_social, direccion, telefono_fijo) VALUES (?, ?, ?, ?)";
         try (PreparedStatement statement = conn.prepareStatement(query))
        {
            statement.setString(1, cuit);
            statement.setString(2, razon_social);
            statement.setString(3, direccion);
            statement.setString(4, tel_fijo);
            statement.execute();
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        }
    }

    @Override
    public void delete(Connection conn, Scanner sc) {
        System.out.println("Insertar CUIT:");
        String cuit = sc.nextLine();

        String query = "DELETE FROM proveedor WHERE CUIT = ?";
        try (PreparedStatement statement = conn.prepareStatement(query))
        {
            statement.setString(1, cuit);
            int filas_afectadas = statement.executeUpdate();
            String respuesta = (filas_afectadas > 0) ? (filas_afectadas + " filas afectadas") : ("No se ha encontrado un proveedor con ese CUIT");
            System.out.println(respuesta);
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        }
    }

    @Override
    public void printAll(Connection conn) {
        String query = "SELECT * FROM proveedor";
        try (PreparedStatement statement = conn.prepareStatement(query))
        {
            ResultSet tuplas = statement.executeQuery();

            System.out.println("#####################################");
            System.out.println("Listado de Proveedores");
            System.out.println("#####################################");

            while (tuplas.next() )
            {
                System.out.println("CUIT: " + tuplas.getString("CUIT"));
                System.out.println("Razon Social: " + tuplas.getString("razon_social"));
                System.out.println("Direccion: " + tuplas.getString("direccion"));
                System.out.println("Telefono Fijo: " + tuplas.getString("telefono_fijo"));
            }
            System.out.println("#####################################");
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        }
    }

} 