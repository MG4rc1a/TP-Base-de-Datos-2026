import java.sql.Connection;
import java.sql.PreparedStatement;
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
         try (PreparedStatement statement = connection.prepareStatement(query))
        {
        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        }
        return;
    }

    @Override
    public void delete(Connection conn, Scanner sc) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'delete'");
    }

    @Override
    public void printAll(Connection conn) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'printAll'");
    }

} 