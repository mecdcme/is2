package it.istat.is2.workflow.batch;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;

import org.hibernate.annotations.DynamicUpdate;

import lombok.Data;

@Data
@Entity
@Table(name = "BATCH_JOB_EXECUTION")
@DynamicUpdate
public class Batch implements Serializable {

    private static final long serialVersionUID = 8488187230261501150L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "JOB_EXECUTION_ID")
    private Long jobExecutionId;

    @Column(name = "WF_ELAB_ID")
    private Long idElaborazione;

    @Column(name = "WF_PROC_ID")
    private Long idProcesso;

    @Column(name = "WF_SESSION_ID")
    private Long idSessione;

    @Column(name = "VERSION")
    private Long version;

    @Column(name = "JOB_INSTANCE_ID")
    private Long jobInstanceId;

    @Column(name = "CREATE_TIME")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createTime;

    @Column(name = "START_TIME")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date startTime;

    @Column(name = "END_TIME")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date endTime;

    @Column(name = "LAST_UPDATED")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date lastUpdated;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "EXIT_CODE")
    private String exitCode;

    @Column(name = "EXIT_MESSAGE")
    private String exitMessage;

    @Column(name = "JOB_CONFIGURATION_LOCATION")
    private String jobConfigurationLocation;

}
