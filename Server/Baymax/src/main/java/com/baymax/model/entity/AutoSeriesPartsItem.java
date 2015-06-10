package com.baymax.model.entity;

import com.baymax.common.Constant;
import lombok.*;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.rest.core.annotation.RestResource;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Killua on 5/30/15.
 */

@Getter
@Setter
@Entity
@Table(name = "t_autoseries_partsitem")
public class AutoSeriesPartsItem {

    @EmbeddedId
    private CompositeId compositeId;

    @RestResource(exported = false)
    @ManyToOne
    @JoinColumn(name = "partsItemId", insertable = false, updatable = false)
    private PartsItem partsItem;


    @Getter
    @Setter
    @EqualsAndHashCode(doNotUseGetters = true)
    @NoArgsConstructor
    @AllArgsConstructor
    @Embeddable
    public static class CompositeId implements Serializable {
        private short seriesId;
        private short partsItemId;

        @Override
        public String toString() {
            final StringBuffer sb = new StringBuffer();
            sb.append(seriesId).append(Constant.HYPHEN).append(partsItemId);
            return sb.toString();
        }
    }

    public static class CompositeIdConverter implements Converter<String, CompositeId> {
        @Override
        public CompositeId convert(String source) {
            int index = source.indexOf(Constant.HYPHEN);
            short seriesId = Short.parseShort(source.substring(0, index));
            short partsItemId = Short.parseShort(source.substring(index+1));
            return new CompositeId(seriesId, partsItemId);
        }
    }
}
