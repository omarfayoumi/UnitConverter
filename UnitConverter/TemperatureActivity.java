import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

public class TemperatureActivity extends AppCompatActivity {
    private EditText inputCelsius;
    private TextView resultText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_temperature);

        inputCelsius = findViewById(R.id.inputCelsius);
        resultText = findViewById(R.id.resultText);

        findViewById(R.id.convertButton).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String celsiusStr = inputCelsius.getText().toString();
                if (celsiusStr != null && celsiusStr.length() > 0) {
                    double celsius = Integer.parseInt(celsiusStr);
                    double fahrenheit = (celsius * 9 / 5) + 32;
                    resultText.setText("Fahrenheit: " + fahrenheit);
                }
            }
        });
    }
}