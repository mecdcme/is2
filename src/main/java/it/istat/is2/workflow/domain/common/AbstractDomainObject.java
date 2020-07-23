package it.istat.is2.workflow.domain.common;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@MappedSuperclass
public abstract class AbstractDomainObject implements Comparable<AbstractDomainObject> {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	protected Long id;
	@Column(name = "NAME")
	protected String name;
	@Column(name = "DESCR")
	protected String descr;

	public int compareTo(AbstractDomainObject abstractDomainObject) {

		return this.id.intValue() - abstractDomainObject.getId().intValue();

	}

}
