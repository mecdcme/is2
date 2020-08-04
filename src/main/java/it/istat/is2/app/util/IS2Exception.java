package it.istat.is2.app.util;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class IS2Exception extends Exception {


    private static final long serialVersionUID = 485598706504813112L;
    private IS2ExceptionCodes code;

    public IS2Exception(IS2ExceptionCodes code) {
        super();
        this.code = code;
    }

    public IS2Exception(IS2ExceptionCodes code, String message) {
        super(message);
        this.code = code;
    }
}
