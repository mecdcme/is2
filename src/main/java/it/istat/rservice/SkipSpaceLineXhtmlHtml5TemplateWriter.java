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

import java.io.IOException;
import java.io.Writer;

import org.thymeleaf.Arguments;
import org.thymeleaf.dom.Comment;
import org.thymeleaf.dom.Element;
import org.thymeleaf.dom.Node;
import org.thymeleaf.dom.Text;
import org.thymeleaf.templatewriter.AbstractGeneralTemplateWriter;

public class SkipSpaceLineXhtmlHtml5TemplateWriter extends AbstractGeneralTemplateWriter {

	@Override
	protected boolean shouldWriteXmlDeclaration() {
		return true;
	}

	@Override
        protected boolean useXhtmlTagMinimizationRules() {
		return true;
	}

	@Override
	protected void writeText(final Arguments arguments, final Writer writer, final Text text) throws IOException {

		final char[] textChars = text.getContent().toCharArray();
		String contentString = new String(textChars);
		if (contentString != null && !contentString.isEmpty() && contentString.trim().length() == 0) {
			return;
		} else {
			super.writeText(arguments, writer, text);
		}
	}

	@Override
	public void writeNode(final Arguments arguments, final Writer writer, final Node node) throws IOException {
		super.writeNode(arguments, writer, node);
		if (node instanceof Element) {
			writer.write("\n");
		} else if (node instanceof Comment) {
			writer.write("\n");
		}

	}
}
