package it.istat.is2.workflow.engine;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import it.istat.is2.app.service.LogService;
import it.istat.is2.workflow.dao.AppRoleDao;
import it.istat.is2.workflow.dao.StepRuntimeDao;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepRuntime;

public class EngineR {


    @Autowired
    AppRoleDao ruoloDao;
    @Autowired
    StepRuntimeDao stepRuntimeDao;
    @Autowired
    LogService logService;

    @Value("${path.script.R}")
    protected String pathR;

    protected String fileScriptR;
    protected String command;
    protected DataProcessing dataProcessing;
    protected StepInstance stepInstance;
    protected LinkedHashMap<String, ArrayList<StepRuntime>> dataMap;
    protected Map<String, AppRole> rolesMap;
    protected Map<String, List<String>> parametersMap;
    protected Map<String, Map<String, List<String>>> worksetVariables;
    protected Map<String, List<String>> rulesetMap;

    protected LinkedHashMap<String, ArrayList<String>> variablesRolesMap;


    protected LinkedHashMap<String, String> parameterOut;

    protected LinkedHashMap<String, String> rolesGroupOut;
}
