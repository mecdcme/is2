/**
 * Copyright 2019 ISTAT
 *
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 *
 * http://ec.europa.eu/idabc/eupl5
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * Licence for the specific language governing permissions and limitations under
 * the Licence.
 *
 * @author Francesco Amato <framato @ istat.it>
 * @author Mauro Bruno <mbruno @ istat.it>
 * @author Paolo Francescangeli  <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
package it.istat.rservice;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.thymeleaf.templatemode.ITemplateModeHandler;
import org.thymeleaf.templatemode.TemplateModeHandler;
import org.thymeleaf.templateparser.html.LegacyHtml5TemplateParser;
import org.thymeleaf.templateparser.xmlsax.XhtmlAndHtml5NonValidatingSAXTemplateParser;
import org.thymeleaf.templateparser.xmlsax.XhtmlValidatingSAXTemplateParser;
import org.thymeleaf.templateparser.xmlsax.XmlNonValidatingSAXTemplateParser;
import org.thymeleaf.templateparser.xmlsax.XmlValidatingSAXTemplateParser;
import org.thymeleaf.templatewriter.XmlTemplateWriter;

public class SkipSpaceLineTemplateModeHandlers {

    // We have to set a maximum pool size. Some environments might set too high
    // numbers for Runtime.availableProcessors (for example, Google App Engine sets
    // this to 1337).
    private final static int MAX_PARSERS_POOL_SIZE = 24;

    public final static ITemplateModeHandler XML;
    public final static ITemplateModeHandler VALIDXML;
    public final static ITemplateModeHandler XHTML;
    public final static ITemplateModeHandler VALIDXHTML;
    public final static ITemplateModeHandler HTML5;
    public final static ITemplateModeHandler LEGACYHTML5;

    public final static Set<ITemplateModeHandler> ALL_TEMPLATE_MODE_HANDLERS;

    static {

        final int availableProcessors = Runtime.getRuntime().availableProcessors();
        final int poolSize
                = Math.min(
                        (availableProcessors <= 2 ? availableProcessors : availableProcessors - 1),
                        MAX_PARSERS_POOL_SIZE);

        XML = new TemplateModeHandler(
                "XML",
                new XmlNonValidatingSAXTemplateParser(poolSize),
                new XmlTemplateWriter());
        VALIDXML = new TemplateModeHandler(
                "VALIDXML",
                new XmlValidatingSAXTemplateParser(poolSize),
                new XmlTemplateWriter());
        XHTML = new TemplateModeHandler(
                "XHTML",
                new XhtmlAndHtml5NonValidatingSAXTemplateParser(poolSize),
                new SkipSpaceLineXhtmlHtml5TemplateWriter());
        VALIDXHTML = new TemplateModeHandler(
                "VALIDXHTML",
                new XhtmlValidatingSAXTemplateParser(poolSize),
                new SkipSpaceLineXhtmlHtml5TemplateWriter());
        HTML5 = new TemplateModeHandler(
                "HTML5",
                new XhtmlAndHtml5NonValidatingSAXTemplateParser(poolSize),
                new SkipSpaceLineXhtmlHtml5TemplateWriter());
        LEGACYHTML5 = new TemplateModeHandler(
                "LEGACYHTML5",
                new LegacyHtml5TemplateParser("LEGACYHTML5", poolSize),
                new SkipSpaceLineXhtmlHtml5TemplateWriter());

        ALL_TEMPLATE_MODE_HANDLERS
                = new HashSet<ITemplateModeHandler>(
                        Arrays.asList(
                                new ITemplateModeHandler[]{XML, VALIDXML, XHTML, VALIDXHTML, HTML5, LEGACYHTML5}));

    }

    public static Set<ITemplateModeHandler> getITemplateModeHandler() {
        return SkipSpaceLineTemplateModeHandlers.ALL_TEMPLATE_MODE_HANDLERS;
    }

    public static ITemplateModeHandler getITemplateModeHandlerHTML5() {
        return HTML5;
    }
}
