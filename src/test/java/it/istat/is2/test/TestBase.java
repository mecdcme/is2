package it.istat.is2.test;

import org.junit.jupiter.api.BeforeEach;
import org.mockito.MockitoAnnotations;

public class TestBase {
    @BeforeEach
    void initMocks() {
        MockitoAnnotations.initMocks(this);
    }
}
