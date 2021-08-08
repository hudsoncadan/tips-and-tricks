import { QuestionBase } from './question-base';

/**
 * Classe que será representa por um elemento <input> 
 * O atributo type estará definido no parâmetro options (por exemplo, text, email, url)
 */
export class TextboxQuestion extends QuestionBase<string> {
    controlType = 'textbox';
}