
package pe.edu.utp.sistemaropa.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author Cristian
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Producto {
    private int idproducto;
    private String nombre;
    private int Stock;
    private double precio;
    private int idproveedor;
}