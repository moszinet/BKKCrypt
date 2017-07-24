package io.github.razorshark.bkkcrypt;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    EditText input;
    TextView output;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        input = (EditText) findViewById(R.id.password_input_field);
        output = (TextView) findViewById(R.id.encrypted_password);
        input.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                output.setText(BKKEncrypt(input.getText().toString()));
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    private String BKKEncrypt(String input){
        return input;
    }
}
