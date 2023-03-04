package ga.heaven.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Getter
@Setter
@ToString
public class CustomerContext {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String dialogContext;
    private long petId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn
    private Customer customer;

    public CustomerContext() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomerContext that = (CustomerContext) o;
        return id == that.id && petId == that.petId && Objects.equals(dialogContext, that.dialogContext);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, dialogContext, petId);
    }

}
