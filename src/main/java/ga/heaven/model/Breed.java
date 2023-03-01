package ga.heaven.model;

import javax.persistence.Entity;
import javax.persistence.*;
import java.util.Objects;

@Entity
public class Breed {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String breed; // порода питомца (key field)
    private String recommendationsChild; // рекомендации по уходу за щенком
    private String recommendationsAdult; // рекомендации по уходу за взрослой собакой
    
    private int adultPetFromAge; // ≥ возраст взрослой собаки (признак взрослой собаки, если больше этого значения)

    public long getId() {
        return id;
    }

    public String getBreed() {
        return breed;
    }

    public String getRecommendationsChild() {
        return recommendationsChild;
    }

    public String getRecommendationsAdult() {
        return recommendationsAdult;
    }

    public int getAdultPetFromAge() {
        return adultPetFromAge;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public void setRecommendationsChild(String recommendationsChild) {
        this.recommendationsChild = recommendationsChild;
    }

    public void setRecommendationsAdult(String recommendationsAdult) {
        this.recommendationsAdult = recommendationsAdult;
    }

    public void setAdultPetFromAge(int adultPetFromAge) {
        this.adultPetFromAge = adultPetFromAge;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Breed that = (Breed) o;
        return adultPetFromAge == that.adultPetFromAge && Objects.equals(breed, that.breed) && Objects.equals(recommendationsChild, that.recommendationsChild) && Objects.equals(recommendationsAdult, that.recommendationsAdult);
    }

    @Override
    public int hashCode() {
        return Objects.hash(breed, recommendationsChild, recommendationsAdult, adultPetFromAge);
    }
}
